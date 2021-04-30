//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <entry/entry_plugin.h>
#include <url_launcher_windows/url_launcher_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  EntryPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("EntryPlugin"));
  UrlLauncherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherPlugin"));
}
