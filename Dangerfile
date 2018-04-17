require 'circleci_artifact'

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet.
has_wip_label = github.pr_labels.any? { |label| label.include? "WIP" }
has_wip_title = github.pr_title.include? "[WIP]"

if has_wip_label || has_wip_title
    warn("PR is classed as Work in Progress")
end

# Warn when there is a big PR.
warn("Big PR") if git.lines_of_code > 500

# Mainly to encourage writing up some reasoning about the PR, rather than just leaving a title.
if github.pr_body.length < 3 && git.lines_of_code > 10
  warn("Please provide a summary in the Pull Request description")
end

src_root = File.expand_path('../app', __FILE__)

xcov.report(
  workspace: "#{src_root}/ProjectName.xcworkspace",
  scheme: "debug-ProjectName",
  output_directory: "#{src_root}/build/xcov",
   # For some reason coverage is on the "develop-" app target instead of "debug-"
  include_targets: "develop-ProjectName.app, Services.framework",
  ignore_file_path: "#{src_root}/fastlane/.xcovignore"
)  

## ** SWIFT LINT ***
# Use the SwiftLint included via CocoaPods
swiftlint.binary_path = "#{src_root}/Pods/SwiftLint/swiftlint"
swiftlint.config_file = "#{src_root}/.swiftlint.yml"

# Run Swift-Lint and warn us if anything fails it
swiftlint.directory = src_root
swiftlint.lint_files inline_mode: true

# Getting artifact URLs from CircleCI

# You must set up the CIRCLE_API_TOKEN manually using these instructions
# https://github.com/Raizlabs/ios-template/tree/master/ProjectName#danger
token = ENV['CIRCLE_API_TOKEN']
# These are already in the Circle environment
# https://circleci.com/docs/2.0/env-vars/#build-specific-environment-variables
username = ENV['CIRCLE_PROJECT_USERNAME']
reponame = ENV['CIRCLE_PROJECT_REPONAME']
build = ENV['CIRCLE_BUILD_NUM']

if !(token.nil? or username.nil? or reponame.nil? or build.nil?)
  fetcher = CircleciArtifact::Fetcher.new token, username, reponame, build

  xcov = CircleciArtifact::Query.new 'xcov/index.html'
  slather = CircleciArtifact::Query.new 'slather/index.html'
  screenshots = CircleciArtifact::Query.new 'screenshots/screenshots.html'
  queries = [xcov, slather, screenshots]
  results = fetcher.fetch(queries)

  xcov_url = results.url_for_query(xcov)
  slather_url = results.url_for_query(slather)
  screenshots_url = results.url_for_query(screenshots)

  if !xcov_url.nil?
      message "[Code Coverage: xcov](#{xcov_url})"
  end

  if !slather_url.nil?
      message "[Code Coverage: Slather](#{slather_url})"
  end

  if !screenshots_url.nil?
      message "[Screenshots](#{screenshots_url})"
  end
else
  warn "Missing CircleCI artifacts. Most likely the [CIRCLE_API_TOKEN](https://github.com/Raizlabs/circleci_artifact#getting-started) is not set, or Danger is not running on CircleCI."
end
