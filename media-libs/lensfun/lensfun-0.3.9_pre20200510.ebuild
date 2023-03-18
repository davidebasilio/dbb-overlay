# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9,10,11} )
inherit python-single-r1 cmake git-r3 #distutils-r1

DESCRIPTION="Library for rectifying and simulating photographic lens distortions"
HOMEPAGE="https://lensfun.github.io"

EGIT_REPO_URI="https://github.com/lensfun/${PN}.git"
EGIT_COMMIT="07ae4a9e4f8a2cc7e2ede5c6b921b093d5674190"
#EGIT_COMMIT="${PV#*_pre}"
KEYWORDS="amd64"

LICENSE="LGPL-3 CC-BY-SA-3.0" # See README for reasoning.
SLOT="0"
IUSE="doc cpu_flags_x86_sse cpu_flags_x86_sse2 test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

BDEPEND="
	doc? (
		app-doc/doxygen
		dev-python/docutils
	)
"
RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.40
	media-libs/libpng:0=
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

DOCS=( README.md docs/mounts.txt ChangeLog )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="${EPREFIX}"/usr/share/doc/${PF}/html
		#-DSETUP_PY_INSTALL_PREFIX="${ED}"/usr
		-DSETUP_PY_INSTALL_PREFIX=/usr
		-DBUILD_LENSTOOL=ON
		-DBUILD_STATIC=OFF
		-DBUILD_DOC=$(usex doc)
		-DBUILD_FOR_SSE=$(usex cpu_flags_x86_sse)
		-DBUILD_FOR_SSE2=$(usex cpu_flags_x86_sse2)
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	mkdir -p "${T}/db/lensfun" || die
	cp data/db/* "${T}/db/lensfun/" || die

	XDG_DATA_HOME="${T}/db" cmake_src_test
}

src_install() {
	cmake_src_install
	python_optimize
}
