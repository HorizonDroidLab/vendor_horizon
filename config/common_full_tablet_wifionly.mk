# Inherit mobile full common stuff
$(call inherit-product, vendor/horizon/config/common_mobile_full.mk)

# Inherit tablet common stuff
$(call inherit-product, vendor/horizon/config/tablet.mk)

$(call inherit-product, vendor/horizon/config/wifionly.mk)
