#
# Copyright (C) 2024-2025 HorizonDroid
#
# SPDX-License-Identifier: Apache-2.0
#

HORIZON_ZIP_NAME := $(HORIZON_VERSION).zip
HORIZON_TARGET_PACKAGE := $(PRODUCT_OUT)/$(HORIZON_ZIP_NAME)

.PHONY: horizon
horizon: $(INTERNAL_OTA_PACKAGE_TARGET)
	@echo "HorizonDroid OTA package"
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(HORIZON_TARGET_PACKAGE)
	@echo ""
	@echo "Package Completed:"
	@echo ""
	@echo "█░█ █▀█ █▀█ █ ▀█ █▀█ █▄░█"
	@echo "█▀█ █▄█ █▀▄ █ █▄ █▄█ █░▀█"
	@echo "═══════════════════════════════════════════════════════════════════"
	@echo "Zip: $(HORIZON_TARGET_PACKAGE)"
	@echo "Size: `du -h "$(HORIZON_TARGET_PACKAGE)" | cut -f1`"
	@echo "SHA256: `sha256sum $(HORIZON_TARGET_PACKAGE) | cut -f 1 -d " "`"
	@echo "MD5: `md5sum $(HORIZON_TARGET_PACKAGE) | cut -f 1 -d " "`"
	@echo "═══════════════════════════════════════════════════════════════════"
	@echo "" >&2
