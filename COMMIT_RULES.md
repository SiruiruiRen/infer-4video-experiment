# Commit Requirements - INFER 4-Video Experiment

## Repository
- **Target Repository**: `infer-4video-experiment` (https://github.com/SiruiruiRen/infer-4video-experiment.git)
- **Remote Name**: `infer-4video`
- **Branch**: `clean-update` → pushes to `main`

## Commit Message Format

```
Brief description (50 chars or less)

Optional detailed explanation if needed
```

### Examples:
```
Fix video link pages: open in new tab, add finished watching button

Update consent page: add mandatory data protection checkbox

Fix generateFeedbackForVideo function and Supabase 406 errors
```

## Commit Rules

### ✅ DO Commit:
- Feature implementations (new pages, functionality)
- Bug fixes
- UI/UX improvements
- Translation updates
- Configuration changes (non-sensitive)
- Documentation updates

### ❌ DON'T Commit:
- API keys or secrets (use environment variables)
- `.env` files with actual credentials
- Temporary/debug files
- Large binary files (images, PDFs) unless necessary
- Personal notes or drafts

## Workflow

1. **Stage changes**:
   ```bash
   git add app.js index.html styles.css
   # Or for all changes:
   git add -A
   ```

2. **Commit with descriptive message**:
   ```bash
   git commit -m "Brief description of changes"
   ```

3. **Push to repository**:
   ```bash
   git push infer-4video clean-update:main
   ```

## Commit Frequency
- Commit after completing logical units of work
- Don't commit broken/incomplete code
- Test locally before committing when possible

## Important Notes
- **Never commit API keys**: Use Render environment variables
- **Always push to `infer-4video` remote**: Not `origin`
- **Render auto-deploys**: Changes push to `main` will auto-deploy in 2-3 minutes

