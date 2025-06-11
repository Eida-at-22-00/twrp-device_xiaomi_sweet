#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;
using std::string;

void property_override(string prop, string value)
{
    auto pi = (prop_info *)__system_property_find(prop.c_str());

    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void vendor_load_properties()
{
    string region = GetProperty("ro.boot.hwc", "");
    string sku = GetProperty("ro.boot.product.hardware.sku", "");

    string prop_partitions[] = {"", "vendor.", "odm."};

    if (region == "GLOBAL" && sku == "pro") {
        for (const string &prop : prop_partitions) {
            property_override("ro.product." + prop + "brand", "Redmi");
            property_override("ro.product." + prop + "name", "sweet_global");
            property_override("ro.product." + prop + "device", "sweet");
            property_override("ro.product." + prop + "model", "M2101K6G");
            property_override("ro.product." + prop + "marketname", "Redmi Note 10 Pro");
            property_override("ro.product.system." + prop + "device", "Redmi Note 10 Pro");
        }
    } else if (region == "INDIA" && sku == "std") {
        for (const string &prop : prop_partitions) {
            property_override("ro.product." + prop + "brand", "Redmi");
            property_override("ro.product." + prop + "name", "sweetin");
            property_override("ro.product." + prop + "device", "sweetin");
            property_override("ro.product." + prop + "model", "M2101K6P");
            property_override("ro.product." + prop + "marketname", "Redmi Note 10 Pro");
            property_override("ro.product.system." + prop + "device", "Redmi Note 10 Pro");
        }
    } else if (region == "INDIA" && sku == "pro") {
        for (const string &prop : prop_partitions) {
            property_override("ro.product." + prop + "brand", "Redmi");
            property_override("ro.product." + prop + "name", "sweetinpro");
            property_override("ro.product." + prop + "device", "sweetin");
            property_override("ro.product." + prop + "model", "M2101K6I");
            property_override("ro.product." + prop + "marketname", "Redmi Note 10 Pro Max");
            property_override("ro.product.system." + prop + "device", "Redmi Note 10 Pro Max");
        }
    }
}
