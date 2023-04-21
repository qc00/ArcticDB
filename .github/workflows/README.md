CI system guide
===============

<!--
<tr><th></th><td></td>
-->

## [publish.yml](publish.yml)

* Gathers the wheels and uploads them to Pypi
* Generates a draft GitHub Release and attaches debug artifacts

**Runs on forks**: Yes. Must create two environments named `TestPypi` and `ProdPypi` with Pypi creds.

### Settings
See also: [`twine` docs](https://twine.readthedocs.io/en/stable/#environment-variables).

<table>
<tr><th>inputs.environment</th><td>Contains the deployment secrets. Should protect with branch rules and approvers</td>
<tr><th>inputs.run_id</th><td>For manual runs, specify the GitHub Action run ID to gather artifacts from</td>
<tr><th>vars.TWINE_USERNAME<br>or secrets.TWINE_USERNAME</th><td colspan="2">Please set API tokens, not real user names and passwords.</td>
<tr><th>secrets.TWINE_PASSWORD</th>
<tr><th>vars.TWINE_REPOSITORY</th><td colspan="3">These three are useful if not publishing to prod Pypi.<br>
    E.g. <code>TWINE_REPOSITORY=testpypi</code>
<tr><th>vars.TWINE_REPOSITORY_URL</th>
<tr><th>vars.TWINE_CERT</th>
</table>

## [docs.yml](docs.yml)

**Runs on forks**: Yes. Must supply a CloudFlare Pages site to upload to

### Call patterns
| Called from       | Environment   | Intended effect
|-------------------|---------------|----------------
| master build      | TestPypi      | Updates the preview site
| version tag build | ProdPypi      | Updates the public/`main` site
| other build^      | null          | Doc syntax check only
| workflow_dispatch | user supplied | Per environment settings

^ `build.yml` is triggered by changes to the code directories only.
If you pushed only docs changes, please use the workflow dispatch to run a build manually
(and supply a suitable ArcticDB wheel from a previous build).

### Settings
<table>
<tr><th>inputs.environment</th><td>Contains the deployment secrets. Should protect with branch rules and approvers</td>
<tr><th>inputs.api_wheel</th><td>In manual runs, overrides the wheel used for Sphinx/API docs generation</td>
<tr><th>vars.CLOUDFLARE_ACCOUNT_ID</th><td colspan="2">See
        <a href="https://developers.cloudflare.com/workers/wrangler/system-environment-variables/">CF docs</a></td>
<tr><th>secrets.CLOUDFLARE_API_TOKEN</th>
<tr><th>vars.CLOUDFLARE_PAGES_PROJECT</th><td>Pages project name</td>
<tr><th>vars.CLOUDFLARE_PAGE_BRANCH</th><td>Even if our CF site is not directly deploying from a git repo,
    it still uses the concept of branches to distinguish "deployments."<br>
    The visibility of each branch is set via the CF console. <code>main</code> is typically the public site.<br>
    Hint: define this variable in Environments<br>
    If not set, will publish to GitHub Pages instead.</td>
</table>
