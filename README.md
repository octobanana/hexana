# hexana
Display file contents in hexadecimal and ASCII.

![hexana](https://raw.githubusercontent.com/octobanana/hexana/master/res/hexana.png)

## Contents
* [About](#about)
* [Usage](#usage)
* [Pre-Build](#pre-build)
  * [Environments](#environments)
  * [Dependencies](#dependencies)
* [Build](#build)
* [Install](#install)
* [License](#license)

## About
__hexana__ is a CLI filter to display file contents in hexadecimal and ASCII.
It is written in x86-64 assembly using Intel syntax targeting the Netwide Assembler.

## Usage
```
hexana < `which hexana`
```

## Pre-Build
This section describes what environments this program may run on,
any prior requirements or dependencies needed, and any third party libraries used.

> #### Important
> Any shell commands using relative paths are expected to be executed in the
> root directory of this repository.

### Environments
* __Linux__

### Dependencies
* __make__
* __nasm__
* __musl__
* __lld__

## Build
```sh
make
```

## Install
```sh
make install
```

## License
This project is licensed under the MIT License.

Copyright (c) 2019 [Brett Robinson](https://octobanana.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
