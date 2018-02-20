<!-- markdownlint-disable MD013 -->

# jdkato.io [![Build Status](https://travis-ci.org/jdkato/jdkato.io.svg?branch=master)](https://travis-ci.org/jdkato/jdkato.io)

<!-- markdownlint-enable MD013 -->

This repository serves two purposes: it houses my personal website (built with
a combination of [Markdown][1], [Hugo][2], [Travis CI][3], and [Netlify][4])
and acts as playground for experimenting with state-of-the-art automated testing
techniques.

The Continuous Integration (CI) pipeline currently includes tests for
**markup**, **spelling**, **links**, and **accessibility**.

## Workflow 101

We follow a workflow similar to [GitHub Flow][5]. As said in the provided link,
there's only one rule:

> Anything on the `master` branch is always deployable.

To ensure this is true, we use a [protected][6] `master` branch. This means that
we never commit directly to `master`&mdash;instead, we create individual
"feature" branches that must pass manual and automated reviews (more on this
below) before being merged.

When working with front-end applications (documentation, a blog, etc.), you
often want proposed changes to pass visual inspection (i.e., after being
rendered) in addition to content-level reviews. In order to avoid having to
maintain multiple local development environments, we use
[Netlify's Deploy Previews][7]. This provides a unique, non-production URL for
each PR.

## CI Pipeline

[1]: https://talk.commonmark.org/t/welcome-to-commonmark-discussion/8
[2]: https://gohugo.io/
[3]: https://travis-ci.org/
[4]: https://www.netlify.com/
[5]: https://guides.github.com/introduction/flow/
[6]: https://help.github.com/articles/about-protected-branches/
[7]: https://www.netlify.com/blog/2016/07/20/introducing-deploy-previews-in-netlify/
