# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/corrados/jamulus/archive/r3_8_0.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/jamulus-r3_8_0"

DEPEND="dev-qt/qtcore dev-qt/qtnetwork dev-qt/qtconcurrent dev-qt/qtxml"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}
