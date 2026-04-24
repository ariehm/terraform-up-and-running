package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAlbExample(t *testing.T) {
	t.Run("should work", func(t *testing.T) {
		opts := &terraform.Options{
			TerraformDir: "../../chp7/module-example/live/prod/data-stores/mysql",
		}

		_ = terraform.InitAndApply(t, opts)

		defer func() {
			_ = terraform.Destroy(t, opts)
		}()

		dbName := terraform.OutputRequired(t, opts, "primary_address")
		assert.NotEmpty(t, dbName)
	})
}
