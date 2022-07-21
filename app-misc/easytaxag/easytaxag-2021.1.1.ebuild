# Copyright 2022 Davide Basilio Bartolini
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

YEAR="${PV%%.*}"
VERSDOT="${PV#*.}"
VERS="${VERSDOT/./_}"
BIN="EasyTax${YEAR}_AG"
ICON="140px-Wappen_Aargau_matt.svg.png"

DESCRIPTION="Steuererklärungstool fürs Kanton Aargau"
HOMEPAGE="https://msg-easytax.ch/ag/"
SRC_URI="https://msg-easytax.ch/ag/${YEAR}/EasyTax${YEAR}AG_unix_${VERS}.tar.gz"

LICENSE=""
SLOT="${YEAR}"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( virtual/jdk virtual/jre )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default
	cd ${WORKDIR}
	mv EasyTax${YEAR}AG ${PF}
}

src_install() {
	insinto /opt/${PF}
	doins -r .
	doins ${FILESDIR}/${ICON}
	fperms +x /opt/${PF}/${BIN}
	dosym /opt/${PF}/${BIN} /usr/bin/${BIN}
	make_desktop_entry /usr/bin/${BIN} ${BIN} /opt/${PF}/${ICON}
}
