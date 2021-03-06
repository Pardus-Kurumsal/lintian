#!/usr/bin/perl

# Copyright (C) 2009 by Raphael Geissert <atomo64@gmail.com>
# Copyright (C) 2009 Russ Allbery <rra@debian.org>
#
# This file is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;

use Test::More;

use Test::Lintian;

# Exclude the following tags, which are handled specially and can't be
# detected by this script.
our $EXCLUDE =join(
    '|', qw(.*-script-but-no-.*-dep$
      .*-contains-.*-control-dir$
      ^maintainer-script-needs-depends-on.*
      .*-contains-.*-file$
      .*-contains-cvs-conflict-copy$
      .*-does-not-load-confmodule$
      .*-name-missing$
      .*-address-missing$
      .*-address-malformed$
      .*-address-looks-weird$
      .*-address-is-on-localhost$
      .*-address-is-root-user$
      .*-address-causes-mail-loops-or-bounces$
      ^wrong-debian-qa-address-set-as-maintainer$
      ^wrong-debian-qa-group-name$
      ^example.*interpreter.*
      ^example-script-.*$
      ^example-shell-script-.*$
      ^privacy-breach-.*$
      ^maintainer-script-should-not-.*$
      ^maintainer-script-may-.*$
      ^install-info-used-in-maintainer-script$
      ^license-problem-cc-by-nc-sa$
      ^license-problem-convert-utf-code$
      ^license-problem-json-evil$
      ^license-problem-non-free-RFC$
      ^license-problem-non-free-RFC-BCP78$
      ^license-problem-nvidia-intellectual$
      ^license-problem-bad-php-license$
      ^license-problem-php-license$
      ^license-problem-gfdl-non-official-text$
      ^license-problem-undefined-license$
      ^maintainer-script-removes-device-files$
      ^suidregister-used-in-maintainer-script$
      ^debian-rules-should-not-.*$
      ^source-contains-prebuilt-.*$
      ^source-contains-autogenerated-.*$
      ^source-contains-data-.*$
      ^invalid-short-name-in-dep5-copyright$
      ^trailing-slash-for-dpkg-maintscript-helper-symlink_to_dir$
      ));

# Exclude "lintian.desc" as it does not have a perl module like other
# checks.
sub accept_filter {
    return !m,/lintian\.desc$,;
}

my $opts = {
    'exclude-pattern' => $EXCLUDE,
    'filter' => \&accept_filter,
};

$ENV{'LINTIAN_TEST_ROOT'} //= '.';

test_tags_implemented($opts, "$ENV{LINTIAN_TEST_ROOT}/checks");
test_tags_implemented("$ENV{LINTIAN_TEST_ROOT}/doc/examples/checks");

done_testing;
