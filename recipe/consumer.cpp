#include <aws/crt/Api.h>
#include <aws/crt/Types.h>
#include <aws/crt/JsonObject.h>
#include <iostream>
int main() {
    Aws::Crt::ApiHandle api;
    const Aws::Crt::String input = "native-arm64";
    const Aws::Crt::Vector<uint8_t> bytes(input.begin(), input.end());
    auto encoded = Aws::Crt::Base64Encode(bytes);
    if (encoded != "bmF0aXZlLWFybTY0" || Aws::Crt::Base64Decode(encoded) != bytes) return 1;
    Aws::Crt::JsonObject value(Aws::Crt::String(R"({"name":"native-arm64","value":-17,"enabled":true})"));
    if (!value.WasParseSuccessful()) return 2;
    auto view = value.View();
    if (view.GetString("name") != input || view.GetInteger("value") != -17 || !view.GetBool("enabled")) return 3;
    std::cout << "Installed CRT initialization, Base64 and JSON checks passed\n";
}
