package main

import (
	"fmt"
	"github.com/fatih/color"
	"github.com/spf13/viper"
)

func main() {

	viper.SetConfigName("app")    // no need to include file extension
	viper.AddConfigPath("config") // set the path of your config file

	err := viper.ReadInConfig()
	if err != nil {
		fmt.Println("Config file not found...")
	} else {
		styleguide_ct := viper.GetString("styleguide.container")
		styleguide_enabled := viper.GetBool("styleguide.enabled")

		color.Yellow("Testing Matrix Overview")

		fmt.Printf("\nStyleguide Config:\n container = %s\n enabled = %t\n",
			styleguide_ct,
			styleguide_enabled)

		spellcheck_ct := viper.GetString("spellcheck.container")
		spellcheck_enabled := viper.GetBool("spellcheck.enabled")

		fmt.Printf("\nSpellcheck Config:\n container = %s\n enabled = %t\n",
			spellcheck_ct,
			spellcheck_enabled)

		toctree_ct := viper.GetString("toctree.container")
		toctree_enabled := viper.GetBool("toctree.enabled")

		fmt.Printf("\nToctree Config:\n container = %s\n enabled = %t\n",
			toctree_ct,
			toctree_enabled)

		// prod_server := viper.GetString("production.server")
		// prod_connection_max := viper.GetInt("production.connection_max")
		// prod_enabled := viper.GetBool("production.enabled")
		// prod_port := viper.GetInt("production.port")

		// fmt.Printf("\nProduction Config found:\n server = %s\n connection_max = %d\n"+
		// 	" enabled = %t\n"+
		// 	" port = %d\n",
		// 	prod_server,
		// 	prod_connection_max,
		// 	prod_enabled,
		// 	prod_port)
	}

}
