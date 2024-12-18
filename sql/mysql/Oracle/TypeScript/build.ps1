# Generated from trgen 0.23.7
if (Test-Path -Path transformGrammar.py -PathType Leaf) {
    $(& python3 transformGrammar.py ) 2>&1 | Write-Host
}

# Because there is no integrated build script for Dart targets, we need
# to manually look at the version in package.json and extract the
# version number. We can then use this with antlr4 to generate the
# parser and lexer.
$version = (Select-String -Path "package.json" -Pattern "antlr4" | ForEach-Object {$_.Line.Split(" ")[5]}) -replace '"|,|\r|\n'

$(& antlr4 -v $version MySQLLexer.g4 -encoding utf-8 -Dlanguage=TypeScript   ; $compile_exit_code = $LASTEXITCODE) | Write-Host
if($compile_exit_code -ne 0){
    exit $compile_exit_code
}
$(& antlr4 -v $version MySQLParser.g4 -encoding utf-8 -Dlanguage=TypeScript   ; $compile_exit_code = $LASTEXITCODE) | Write-Host
if($compile_exit_code -ne 0){
    exit $compile_exit_code
}


$(& npm install -g typescript ts-node ; $compile_exit_code = $LASTEXITCODE ) | Write-Host
if($compile_exit_code -ne 0){
    exit $compile_exit_code
}

$(& npm install ; $compile_exit_code = $LASTEXITCODE ) | Write-Host
if($compile_exit_code -ne 0){
    exit $compile_exit_code
}

if (Test-Path -Path "original") {
    Remove-Item "original" -Recurse -Force
}

$(& tsc -p tsconfig.json --pretty ; $compile_exit_code = $LASTEXITCODE ) | Write-Host

exit $compile_exit_code
