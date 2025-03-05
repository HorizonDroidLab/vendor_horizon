HORIZON_REVISION := v5.0
HORIZON_CODENAME := Nebula
HORIZON_BUILD_DATE := $(shell date +"%d%m%Y-%H%M")

MAINTAINER_LIST = $(shell cat horizon-maintainers/maintainers.list)
DEVICE_LIST = $(shell cat horizon-maintainers/devices.list)

ifeq ($(filter $(HORIZON_BUILD), $(DEVICE_LIST)), $(HORIZON_BUILD))
   ifeq ($(filter $(HORIZON_MAINTAINER), $(MAINTAINER_LIST)), $(HORIZON_MAINTAINER))
      HORIZON_BUILD_TYPE := OFFICIAL
  else
     # the builder is overriding official flag on purpose
     ifeq ($(HORIZON_BUILD_TYPE), OFFICIAL)
       $(error **********************************************************)
       $(error *     A violation has been detected, aborting build      *)
       $(error **********************************************************)
       HORIZON_BUILD_TYPE := UNOFFICIAL
     else
       $(warning **********************************************************************)
       $(warning *   There is already an official maintainer for $(HORIZON_BUILD)    *)
       $(warning *              Setting build type to UNOFFICIAL                      *)
       $(warning *    Please contact current official maintainer before distributing  *)
       $(warning *              the current build to the community.                   *)
       $(warning **********************************************************************)
       HORIZON_BUILD_TYPE := UNOFFICIAL
     endif
  endif
else
   ifeq ($(HORIZON_BUILD_TYPE), OFFICIAL)
     $(error **********************************************************)
     $(error *     A violation has been detected, aborting build      *)
     $(error **********************************************************)
   endif
  HORIZON_BUILD_TYPE := UNOFFICIAL
endif

ifdef HORIZON_MAINTAINER
PRODUCT_PRODUCT_PROPERTIES += \
   ro.horizon.maintainer=$(HORIZON_MAINTAINER)
endif

HORIZON_VERSION := HorizonDroid-$(HORIZON_REVISION)-$(HORIZON_CODENAME)-$(HORIZON_BUILD)-$(HORIZON_BUILD_TYPE)-$(HORIZON_BUILD_DATE)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.horizon.build_date=$(HORIZON_BUILD_DATE) \
    ro.horizon.build_type=$(HORIZON_BUILD_TYPE) \
    ro.horizon.build_version=$(HORIZON_REVISION) \
    ro.horizon.codename=$(HORIZON_CODENAME) \
    ro.horizon.device=$(HORIZON_BUILD) \
    ro.horizon.version=$(HORIZON_VERSION)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/horizon/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/horizon/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/horizon/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/horizon/signing/keys/otakey.x509.pem
endif
endif
