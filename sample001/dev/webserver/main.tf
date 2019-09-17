# see: https://www.terraform.io/docs/providers/azurerm/r/app_service.html
resource "azurerm_resource_group" "test" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "test" {
  name                = "__server_name__"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "__server_name__"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"

  app_settings = {
     APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.test.instrumentation_key}"
		 APPINSIGHTS_PROFILERFEATURE_VERSION = "1.0.0"
		 APPINSIGHTS_SNAPSHOTFEATURE_VERSION = "1.0.0"
		 ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
		 DiagnosticServices_EXTENSION_VERSION = "~3"
		 InstrumentationEngine_EXTENSION_VERSION = "~1"
		 SnapshotDebugger_EXTENSION_VERSION = "~1"
		 XDT_MicrosoftApplicationInsights_Mode = "recommended"
		 XDT_MicrosoftApplicationInsights_BaseExtensions = "~1"
  }

}
resource "azurerm_application_insights" "test" {
  name                = "tf-test-appinsights"
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.test.name}"
  application_type    = "web"
}