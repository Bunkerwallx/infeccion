#ifndef APK_TOOL_H
#define APK_TOOL_H

void decompile_apk(const char *apk_file, const char *output_dir);
void inject_payload(const char *target_dir, const char *payload_file);
void recompile_apk(const char *input_dir, const char *output_apk);
void sign_apk(const char *apk_file, const char *keystore, const char *alias, const char *storepass);
void check_permissions();
void fetch_data(const char *url, const char *output_file);
void download_specific_apk();
void show_menu();

#endif
