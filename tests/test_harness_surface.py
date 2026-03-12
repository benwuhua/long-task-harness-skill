#!/usr/bin/env python3
"""
Packaging-level checks for harness-engineering surface assets.
"""

from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent


def read_text(relative_path):
    return (REPO_ROOT / relative_path).read_text(encoding="utf-8")


def test_readme_mentions_harness_engineering():
    """Both root READMEs should surface harness engineering explicitly."""
    assert "Harness Engineering" in read_text("README.md")
    assert "Harness Engineering" in read_text("README_EN.md")


def test_harness_doc_exists():
    """The repo should include a dedicated harness engineering guide."""
    harness_doc = REPO_ROOT / "docs" / "HARNESS_ENGINEERING.md"
    assert harness_doc.exists(), "Missing docs/HARNESS_ENGINEERING.md"


def test_harness_templates_exist():
    """The repo should ship concrete harness templates."""
    expected = [
        REPO_ROOT / "docs" / "templates" / "env-guide-template.md",
        REPO_ROOT / "docs" / "templates" / "long-task-guide-template.md",
        REPO_ROOT / "docs" / "templates" / "runbook-template.md",
        REPO_ROOT / "docs" / "templates" / "artifacts-readme-template.md",
    ]
    for path in expected:
        assert path.exists(), f"Missing template: {path.relative_to(REPO_ROOT)}"


def test_harness_structure_markers_exist():
    """The repo should make runbooks and artifacts visible by inspection."""
    expected = [
        REPO_ROOT / "docs" / "runbooks" / "README.md",
        REPO_ROOT / "artifacts" / "README.md",
    ]
    for path in expected:
        assert path.exists(), f"Missing structure marker: {path.relative_to(REPO_ROOT)}"


if __name__ == "__main__":
    tests = [
        test_readme_mentions_harness_engineering,
        test_harness_doc_exists,
        test_harness_templates_exist,
        test_harness_structure_markers_exist,
    ]

    failures = 0
    for test in tests:
        try:
            test()
            print(f"PASS: {test.__name__}")
        except Exception as exc:
            failures += 1
            print(f"FAIL: {test.__name__}: {exc}")

    raise SystemExit(1 if failures else 0)
