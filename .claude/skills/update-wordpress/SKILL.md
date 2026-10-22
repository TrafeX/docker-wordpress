---
name: update-wordpress
description: Update the WordPress version in this repo to the latest stable release. Looks up the newest stable version on wordpress.org/download/releases, then sets WORDPRESS_VERSION and WORDPRESS_SHA1 in the Dockerfile and the installed version in README.md. Use when the user asks to update, upgrade or bump WordPress.
---

# Update WordPress

The WordPress version lives in three places:

- `Dockerfile`: `ENV WORDPRESS_VERSION=<version>`
- `Dockerfile`: `ENV WORDPRESS_SHA1=<sha1 of wordpress-<version>.tar.gz>`
- `README.md`: `_WordPress version currently installed:_ **<version>**`

Leave the example versions elsewhere in README.md (e.g. `6.8.1` in the tagging section) untouched.

## Steps

1. **Find the latest stable version.** The release archive lists releases newest first; beta and RC builds have suffixes like `-beta1`/`-RC1`, which this pattern skips:

   ```sh
   curl -fsSL https://wordpress.org/download/releases/ \
     | grep -oE 'wordpress-[0-9]+(\.[0-9]+)+\.tar\.gz' | head -1
   ```

   Take the version from that filename. Compare it with the current `WORDPRESS_VERSION` in the Dockerfile. If it is not newer, tell the user WordPress is already up to date and stop.

2. **Get the SHA1.** The release archive links each tarball's checksum at `https://wordpress.org/wordpress-<version>.tar.gz.sha1`:

   ```sh
   curl -fsSL https://wordpress.org/wordpress-<version>.tar.gz.sha1
   ```

   It must be exactly 40 hex characters. Then verify it against the tarball itself, downloaded into the scratchpad (not the repo):

   ```sh
   curl -fsSL -o <scratchpad>/wordpress.tar.gz https://wordpress.org/wordpress-<version>.tar.gz
   echo "<sha1> *<scratchpad>/wordpress.tar.gz" | sha1sum -c -
   ```

   If the check fails, stop and report it; do not write the hash.

3. **Update the files.** Replace the version and SHA1 in the Dockerfile and the version in the README.md line shown above.

4. **Check the result.** `git diff` should show exactly three changed lines: two in `Dockerfile`, one in `README.md`. Optionally run `docker build .` to confirm the image builds with the new hash.

5. **Commit only if the user asks.** Use the repo's existing message style: `Upgrade WordPress to <version>`.
