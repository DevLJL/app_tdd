@echo off
set /p input=Insira o nome da categoria a ser testada:

if "%input%" == "" (
    echo Executando todos os testes.
    crud_test.exe
) else (
    echo Executando o teste com a categoria informada.
    crud_test.exe --include:%input%
)

pause
