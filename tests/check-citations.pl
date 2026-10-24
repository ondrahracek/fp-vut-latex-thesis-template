#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use FindBin qw($RealBin);
use File::Spec;
use Cwd qw(abs_path);

binmode STDOUT, ':encoding(UTF-8)';
binmode STDERR, ':encoding(UTF-8)';

my $root = abs_path(File::Spec->catdir($RealBin, '..'));
chdir $root or die "Nelze přejít do $root: $!\n";

my @build = (
    'latexmk', '-g', '-pdf', '-interaction=nonstopmode', '-halt-on-error',
    '-outdir=build/tests', 'tests/citations.tex',
);
system @build;
die "Překlad citačního testu selhal (exit " . ($? >> 8) . ").\n" if $? != 0;

sub read_utf8 {
    my ($path) = @_;
    open my $handle, '<:encoding(UTF-8)', $path
        or die "Nelze přečíst $path: $!\n";
    local $/;
    return <$handle>;
}

sub check {
    my ($ok, $name) = @_;
    die "SELHALO: $name\n" unless $ok;
    print "OK: $name\n";
}

sub ordered {
    my ($text, @parts) = @_;
    my $position = -1;
    for my $part (@parts) {
        my $next = index($text, $part, $position + 1);
        return 0 if $next < 0;
        $position = $next;
    }
    return 1;
}

my $bbl = read_utf8('build/tests/citations.bbl');
my $aux = read_utf8('build/tests/citations.aux');
my $blg = read_utf8('build/tests/citations.blg');

my @keys = ($bbl =~ /\\bibitem\{([^}]+)\}/g);
my @expected_keys = qw(
    zeta-book alpha-article corporate-web conference-editors many-authors online-book dated-web
);
check(join("\0", @keys) eq join("\0", @expected_keys),
    'pořadí bibliografie podle prvního odkazu');

my %record;
while ($bbl =~ /\\bibitem\{([^}]+)\}(.*?)(?=\\bibitem\{|\\end\{thebibliography\})/sg) {
    $record{$1} = $2;
}
check(ordered($record{'zeta-book'}, 'Zkušební', 'Zuzana', 'Druhý', 'Bohumil'),
    'plná jména autorů knihy');
check(ordered($record{'alpha-article'}, 'Example', 'Alice', 'Pokusný', 'Bedřich'),
    'plná jména autorů článku');
check(index($record{'corporate-web'}, '{Korporace pro testování stylu}') >= 0,
    'korporativní autor');
check(ordered($record{'conference-editors'}, 'Konferenční', 'Cyril',
    'První', 'Edita', 'Druhý', 'Emil', 'ed.'), 'autor a editoři sborníku');
check(ordered($record{'many-authors'}, 'První', 'Adam', 'Druhá', 'Barbora',
    'Třetí', 'Cyril', 'Čtvrtá', 'Dana', 'Pátý', 'Emil', 'et~al.')
    && index($record{'many-authors'}, 'Františka') < 0
    && index($record{'many-authors'}, 'Šestá') < 0,
    'limit pěti autorů a et al.');

check(ordered($record{'alpha-article'}, 'Syntetický článek s DOI', 'Online',
    'Časopis testovacích záznamů', '2024',
    'https://doi.org/10.0000/example.article', '[cit. 2026-10-24]'),
    'pořadí názvu, Online, časopisu, roku, DOI a data citování u článku');
check(ordered($record{'corporate-web'}, 'Syntetická webová stránka', 'Online',
    'In: Testovací web',
    'https://example.invalid/corporate', '[cit. 2026-10-24]'),
    'pořadí názvu, Online, hostitele, URL a data citování u webu');
check(ordered($record{'conference-editors'},
    'Syntetický konferenční příspěvek', 'Online', 'In:',
    'Sborník testovacích příspěvků', '2023',
    'https://doi.org/10.0000/example.conference', '[cit. 2026-10-24]'),
    'pořadí názvu, Online, sborníku, roku, DOI a data citování u příspěvku');

check(ordered($record{'online-book'}, 'Syntetická online kniha', 'Online', '2024',
    'https://doi.org/10.0000/example.book', '[cit. 2026-10-24]'),
    'online kniha s resolverem v poli URL');
check(ordered($record{'dated-web'}, 'Syntetický datovaný web', 'Online',
    'In: Web s datem publikace', '3. února 2024', 'https://example.invalid/dated', '[cit. 2026-10-24]'),
    'publikační datum webu před URL a datem citování');

my @citations = ($aux =~ /\\citation\{([^}]+)\}/g);
check(join('|', @citations) eq
    'zeta-book|alpha-article|alpha-article|corporate-web|conference-editors|many-authors|online-book|dated-web',
    'opakovaná a vícenásobná citace');

my @warnings = ($blg =~ /^(Warning--.*)$/mg);
my @expected_warnings = (
    'Warning--empty edition in alpha-article',
    'Warning--empty year in corporate-web',
    'Warning--empty year and revised in corporate-web',
    'Warning--empty isbn and issn in conference-editors',
);
check(join("\0", @warnings) eq join("\0", @expected_warnings),
    'přesně zdokumentovaná varování BibTeXu');

print "Všechny kontroly citačního stylu prošly.\n";
