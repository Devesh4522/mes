# AGENTS

Purpose: Provide short, actionable guidance for AI coding agents working in this repository.

**Focus: Git commit guidance (git commit)**

- **Commit message format:** Use Conventional Commits style:
  - `type(scope): Short imperative summary`
  - Blank line, then a body wrapped ~72 chars describing the rationale and what changed.
  - Footer for references or breaking changes: `BREAKING CHANGE: description` or ticket links.

- **Allowed types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.

- **Subject rules:** Keep the subject <=72 characters, imperative mood ("add", "fix", "remove"), include scope when descriptive.

- **Body rules:** Explain why the change was made and any important notes for reviewers. Include a short list of affected files when the change spans multiple areas.

- **When the agent composes commits:**
  - Run or suggest running tests/builds before committing; link to [README.md](README.md) for project-specific steps.
  - Prefer multiple small, logical commits over one large commit. Keep each commit atomic.
  - For lint/format-only changes use `style` or `chore` and mention the tool (e.g., `clang-format`).
  - If a conventional ticket/issue ID exists, include it in the footer (e.g., `Refs: #123`).
  - If co-authored contributions are present, add `Co-authored-by: Name <email>` lines in the footer.

- **Commit message examples:**
  - `feat(renderer): add basic texture caching`
  - `fix(auth): correct token refresh for expired sessions`
  - `docs: update README with build instructions`

- **Commit template:**
  - Subject: `type(scope): short summary`
  - Body: 1-3 paragraphs explaining the change
  - Footer: `Refs: #<issue>` / `Co-authored-by:` / `BREAKING CHANGE:`

- **AI-agent responsibilities when preparing a commit:**
  - Provide the proposed commit message and a terse summary of changed files before creating the commit.
  - If multiple change clusters are detected, propose splitting into multiple commits and name each commit accordingly.
  - For any code changes, include a brief test plan or verification steps in the commit body.

**Where to update/improve these rules**
- Edit this file and keep guidance minimal; link to more detailed docs when available.

--
Generated agent guidance: git commit conventions and templates for AI contributors.
