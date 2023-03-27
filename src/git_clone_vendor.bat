@echo off

set folder=Vendor

if not exist %folder% (
    mkdir %folder%
) else (
    rmdir /s /q %folder%
    mkdir %folder%
)

cd %folder%

git clone https://github.com/ezequieljuliano/DataSetConverter4Delphi.git
git clone https://github.com/viniciussanchez/dataset-serialize.git
git clone https://github.com/DevLJL/SmartPointer.git
git clone https://github.com/DevLJL/ZLConnection.git

pause