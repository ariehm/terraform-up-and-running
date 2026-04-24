
# Testing Rules

You can test terraform modules with GO CODE! :ahhhhh:

Check out:

  https://terratest.gruntwork.io/docs/getting-started/quick-start/

Super ka-DUPER cool.

## Dependency Injection - Now in Terraform!

You can totally use dependency injection concepts in terraform modules, which
makes it easier to test individual modules in isolation.  You have to be
careful about how you structure your inputs and outputs, but if you do it right,
it's a beautiful thing.

## Integration Tests

The examples/ folder with working examples is the basis for a lot of the tests
in this chapter.  Since I skipped on that last week, I don't have them, but the
gist is that you make a folder structure like so:

```
<root>/
  modules/
    foo/
  examples/
    foo-single-thing/
    foo-multiple-things/
  tests/
    foo/
```

The examples contains working real examples you can "terraform apply".

The tests/ folder contains all the go code (using terratest!), and that should
pull in the examples and terraform init/apply/destroy them, with some go code
in the middle (after things have spun up) to verify things "look right".

## Test Stages

You can wrap your code in stages, and then (with env vars) dynamically skip
some of them.  This lets you do something like this... Say you have 5 stages:
1. Spin up DB
2. Spin up app
3. Validate the app
4. Destroy the app
5. Destroy the DB

Here's what that would look like in pseudo-code:

```go
  // code examples fit better in the book.
  stage := test_structure.RunTestStage

  // Deploy the MySQL DB
  defer stage(t, "teardown_db", func() { teardownDb(t, dbDirStage) })
  stage(t, "deploy_db", func() { deployDb(t, dbDirStage) })

  // Deploy the hello-world-app
  defer stage(t, "teardown_app", func() { teardownApp(t, appDirStage) })
  stage(t, "deploy_app", func() { deployApp(t, dbDirStage, appDirStage) })

  // Validate the hello-world-app works
  stage(t, "validate_app", func() { validateApp(t, appDirStage) })
```

By wrapping the different bits in stages, you can then run a test that doesn't
do any "destroy" steps:
```
  $ SKIP_teardown_db=true \
    SKIP_teardown_app=true \
    go test -timeout 30m -run 'TestHelloWorldAppStageWithStages'
```

Now you can re-run the validation tests (tight inner loop for rapid development)
but skip all the long startup penalties (state is cached on disk):
```
  $ SKIP_deploy_db=true \
    SKIP_deploy_app=true \
    SKIP_teardown_app=true \
    SKIP_teardown_app=true \
    go test -timeout 30m -run 'TestHelloWorldAppStageWithStages'
```

When you're done, don't forget to run the destroy steps (by skipping everything
else):
```
  $ SKIP_deploy_db=true \
    SKIP_deploy_app=true \
    SKIP_validate_app=true \
    go test -timeout 30m -run 'TestHelloWorldAppStageWithStages'
```

## Retries!

Infrastructure can be flaky - add retries to fix a lot of the random noise!

Example:

```go
return &terraform.Options{
    TerraformDir: terraformDir,

    Vars: map[string]interface{}{
      "db_remote_state_bucket": dbOpts.BackendConfig["bucket"],
      "db_remote_state_key": dbOpts.BackendConfig["key"],
      "environment": dbOpts.Vars["db_name"],
    },
    // Retry up to 3 times, with 5 seconds between retries,
    // on known errors
    MaxRetries: 3,
    TimeBetweenRetries: 5 * time.Second,
    RetryableTerraformErrors: map[string]string{
      "RequestError: send request failed": "Throttling issue?",
    },
}  
```
