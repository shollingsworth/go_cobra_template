package cmd

import (
	"fmt"

	"github.com/shollingsworth/changeme/util"
	"github.com/spf13/cobra"
)

var SubCmd = &cobra.Command{
	Use:     "subcmd",
	Short:   "subcommand",
	Aliases: []string{"f"},
}


var HelloWorldSubCmd = &cobra.Command{
	Use:     "test [output string]",
	Short:   "test output",
	Aliases: []string{"cd"},
	Run: func(cmd *cobra.Command, args []string) {
		arg1 := args[0]
        cmd_str := fmt.Sprintf("echo %s", arg1)
		out, err := util.ExecAllOut(cmd_str)
		if err != nil {
			fmt.Println(err)
			return
		}
		fmt.Println(out)
	},
}

func init() {
	HelloWorldSubCmd.Args = cobra.MinimumNArgs(1)
	SubCmd.AddCommand(HelloWorldSubCmd)
	rootCmd.AddCommand(SubCmd)
}
