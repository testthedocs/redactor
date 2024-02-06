// Copyright © 2018 NAME HERE <EMAIL ADDRESS>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"fmt"
	"os"
    "os/exec"

	"github.com/spf13/cobra"
)

// valeCmd represents the vale command
var valeCmd = &cobra.Command{
	Use:   "vale",
	Short: "Runs vale suite against your docs",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
Run: func(cmd *cobra.Command, args []string) {
	   if len(args) > 0 {
		   runVale("testthedocs/ttd-vale " + args[0])
        } else {
			runVale("testthedocs/ttd-vale")
		}
	},
}

func runVale(params string) {
	fmt.Printf("%v", params)

	cmdStr := "docker run -it --rm -v `pwd`:/srv/tests " + files
        cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Run()
        //fmt.Println("Test Output")
	//cmdStr := "docker run -it --rm -v `pwd`:/docs wundertax/mkdocs:latest build"
	//out, _ := exec.Command("/bin/sh", "-c", cmdStr).Output()
	//fmt.Printf("%s", out)
}

func init() {
	rootCmd.AddCommand(valeCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// valeCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// valeCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
