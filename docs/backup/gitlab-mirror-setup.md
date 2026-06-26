# GitLab Mirror Setup

## Prerequisites

1. Create a private repository on GitLab for this workspace mirror (default local name: `awcms-sskobar`)
2. Create a GitLab Personal Access Token (PAT) with `write_repository` scope

The current root automation defaults `GITLAB_REPO_NAME` to `awcms-sskobar` in `scripts/sync-sskobar-env.sh`, so use that unless you intentionally choose a different mirror name.

## Setup Steps

### 1. Create a PAT

Create a GitLab PAT with `write_repository` scope in your GitLab account settings.

### 2. Add Secrets to GitHub

Go to GitHub repo → Settings → Secrets and variables → Actions → New repository secret:

| Secret Name        | Value                |
| ------------------ | -------------------- |
| `GITLAB_USERNAME`  | Your GitLab username |
| `GITLAB_REPO_NAME` | `awcms-sskobar` (or your chosen mirror repo) |
| `GITLAB_PAT`       | GitLab PAT token     |

### 3. Initial Push

Do an initial push to create the repo on GitLab:

```bash
git remote add gitlab "https://oauth2:${GITLAB_PAT}@gitlab.com/${GITLAB_USERNAME}/${GITLAB_REPO_NAME}.git"
git push --all gitlab
git push --tags gitlab
```

For local backup scripts, `scripts/backup/load-config.sh` safely reads encrypted backup config first and then overlays local `.env` files when present.

### 4. Verify

After the next push to GitHub, check the Actions tab to see the mirror workflow run.

Also review `.github/workflows/mirror-to-gitlab.yml`: the current workflow has a repository-slug guard and only runs when that condition is satisfied or intentionally updated.

If the mirror variables or PAT are missing, the workflow now skips the mirror step instead of failing the push.

## Troubleshooting

- **Repository not found**: Check `GITLAB_USERNAME` and `GITLAB_REPO_NAME`
- **Permission denied**: Verify the PAT has `write_repository` scope
- **Workflow skipped**: Confirm the GitHub repository variables and `GITLAB_PAT` secret are set
