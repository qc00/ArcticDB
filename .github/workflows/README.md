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
