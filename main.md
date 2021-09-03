---
title: "Setup & build guide for OP-TEE"
subtitle: "Part of the TACOS project"
subject: "OP-TEE guide"
keywords: [OP-TEE, TACOS, QEMU]
author: Tom Van Eyck
date: \today
titlepage: true
titlepage-background: figures/background.pdf
toc-own-page: true
lang: "en"
...

<!-- Prerequisites -->

!include prerequisites/main.md

<!-- Build & run -->

!include setup/main.md

<!-- Debug -->

!include debug/main.md

<!-- Custom PTA -->

!include pta/main.md

<!-- Serial interrupt -->

!include serial-itr/main.md

<!-- Callback on interrupt -->

!include callback/main.md

<!-- Bibliography -->

!include bib.md
