[![Hex Docs][hex badge]][hex]
[![Tests][tests badge]][tests]
[![Codecov][codecov badge]][codecov]

# Concuerror

Concuerror is a stateless model checking tool for Erlang programs. It can be used to systematically test programs for concurrency errors, detect and report errors that only occur on few, specific schedulings or **verify** their absence.

[Visit the website][website] for documentation, examples, tutorials, publications, and many more!

# Changes for supporting PETR coverage
This repository was created as part of the work for the paper “Coverage Metrics for Actor Model Programs: A Model-Based Approach.” It extends Concuerror, a systematic concurrency testing tool for Erlang programs, by integrating the PETR coverage metric as a guiding mechanism for scheduling decisions. The modifications aim to enhance Concuerror’s ability to explore execution paths more effectively by leveraging model-based coverage metrics. With this change we have pair_of_event_type_receive in shchudling option like oldest and newest in [scheduling option][https://hexdocs.pm/concuerror/concuerror_options.html#type-scheduling] . For more details, please refer to the original paper and the extended implementation provided in this repository.

Here’s the English version of the text you can include in the README file of your project:

---

### Reproducing Results from Section 5.2 of the Paper

A portion of the experiments presented in Section 5.2 of the paper can be reproduced by running the tests on actual scenarios. To facilitate this, a dedicated branch has been created, which contains the necessary test suite. You can find it at the following address:

[https://github.com/sajad22/ConcuerrorPETR/tree/test-suite](https://github.com/sajad22/ConcuerrorPETR/tree/test-suite)

To allow the tests to run with different schedulers, minor modifications have been made to the code. These changes are documented in the latest commit on the branch.

#### Instructions for Running Tests

To execute the tests with the default `round_robin` scheduler, run the following command:

```bash
make tests-3 SC=round_robin
```

To compare the results, you can run the tests with a different scheduler, such as `pair_of_event_type_receive`, using the command:

```bash
make tests-3 SC=pair_of_event_type_receive
```

By comparing the outputs of these two commands, you can reproduce one of the key experiments described in the paper.


## Supported OTP Releases

[![Erlang Versions][erlang versions badge]][tests]

## How to build

* Compile             : `make`
* Build documentation : `make edoc`
* Run the testsuites  : `make tests tests-real tests-unit`
* Run Dialyzer        : `make dialyzer`
* Run Elvis           : `make lint`
* Check code coverage : `make cover`
* Cleanup             : `make clean`

The preferred way to start concuerror is via the `bin/concuerror` escript.

## Is there bash_completion?

[Yes!][bash_completion]

## Is there a changelog?

[Yes!][changelog]

## How to prepare for a release?

[Read this][release]

## Copyright and License

Copyright (c) 2014-2023,
Stavros Aronis (<aronisstav@gmail.com>) and
Kostis Sagonas (<kostis@cs.ntua.gr>).
All rights reserved

Copyright (c) 2011-2013,
Alkis Gotovos (<el3ctrologos@hotmail.com>),
Maria Christakis (<mchrista@softlab.ntua.gr>) and
Kostis Sagonas (<kostis@cs.ntua.gr>).
All rights reserved.

Concuerror is distributed under the Simplified BSD License.
Details can be found in the [LICENSE][license] file.

<!-- Links -->
[bash_completion]: ./resources/bash_completion/concuerror
[changelog]: ./CHANGELOG.md
[codecov]: https://codecov.io/gh/parapluu/Concuerror
[hex]: https://hexdocs.pm/concuerror/
[license]: ./LICENSE
[release]: ./resources/how-to-release.md
[tests]: https://github.com/parapluu/Concuerror/actions/workflows/tests.yml
[website]: http://parapluu.github.io/Concuerror

<!-- Badges -->
[codecov badge]: https://codecov.io/gh/parapluu/Concuerror/branch/master/graph/badge.svg
[erlang versions badge]: https://img.shields.io/badge/erlang-20.3%20to%2023.3-blue.svg
[hex badge]: https://img.shields.io/badge/hex-docs-green.svg
[tests badge]: https://github.com/parapluu/Concuerror/actions/workflows/tests.yml/badge.svg
