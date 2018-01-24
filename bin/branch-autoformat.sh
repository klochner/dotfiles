#!/usr/bin/env bash
#set -x
set -eu -o pipefail

# This script needs to be invoked from the root expedite-scala directory.

# Improvements
# * Use nailgun not pay the scalafmt start up cost each time.
#   (possible benefit, not sure about possibility)
# * Have ./pants generate the classpath for scalafmt.
#   (definite benefit, not sure about possibility)

JAR_PATH=".pants.d/ivy/jars/"
SCALAFMT_CONF="build-support/scalafmt/scalafmt.conf"

# ELI5
# git status --short
# * limits the status output to tracked and untracked file statuses
# sed -Ee '/^ A|^ M|^\?\?/!d' -e '/\.scala$/!d'
# * -E is for extended regular expressions
# * -e is an expression (multiple in a chain are evaluated left-to-right
# * /.../ is the command to match a pattern where ... is the pattern
# * !d is the command to reverse the match (!)
# * '^[ ]?A' is for added files (there is a leading space for dirty files)
# * '^[ ]?M' is for modified files (there is a leading space for dirty files)
# * '^\?\?' is for untracked files
# * '\.scala$' is for the '.scala' file extension
# cut -c 4-
# * take characters (-c) from the 4th one to the end of the line inclusive (4-)
# tr '\n' ','
# * translates all occurrences of the newlines into commas
FILES=$(git diff master --diff-filter=AM --name-only | tr '\n' ' ')

# Exit early if we do not files to format
if [[ -z "${FILES}" ]]; then
  echo "No changed files found to format."
  exit
fi

java -cp ${JAR_PATH}com.geirsson/scalafmt-cli_2.11/jars/scalafmt-cli_2.11-1.1.0.jar:${JAR_PATH}com.geirsson/scalafmt-core_2.11/jars/scalafmt-core_2.11-1.1.0.jar:${JAR_PATH}com.geirsson/metaconfig-core_2.11/jars/metaconfig-core_2.11-0.4.0.jar:${JAR_PATH}org.scala-lang/scala-library/jars/scala-library-2.11.11.jar:${JAR_PATH}org.scalameta/inputs_2.11/jars/inputs_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/common_2.11/jars/common_2.11-1.7.0.jar:${JAR_PATH}com.lihaoyi/sourcecode_2.11/jars/sourcecode_2.11-0.1.3.jar:${JAR_PATH}org.scalameta/io_2.11/jars/io_2.11-1.7.0.jar:${JAR_PATH}com.geirsson/metaconfig-typesafe-config_2.11/jars/metaconfig-typesafe-config_2.11-0.4.0.jar:${JAR_PATH}com.typesafe/config/jars/config-1.2.1.jar:${JAR_PATH}org.scalameta/scalameta_2.11/jars/scalameta_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/dialects_2.11/jars/dialects_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/inline_2.11/jars/inline_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/parsers_2.11/jars/parsers_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/tokenizers_2.11/jars/tokenizers_2.11-1.7.0.jar:${JAR_PATH}com.lihaoyi/scalaparse_2.11/jars/scalaparse_2.11-0.4.2.jar:${JAR_PATH}com.lihaoyi/fastparse_2.11/jars/fastparse_2.11-0.4.2.jar:${JAR_PATH}com.lihaoyi/fastparse-utils_2.11/jars/fastparse-utils_2.11-0.4.2.jar:${JAR_PATH}org.scalameta/tokens_2.11/jars/tokens_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/trees_2.11/jars/trees_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/quasiquotes_2.11/jars/quasiquotes_2.11-1.7.0.jar:${JAR_PATH}org.scalameta/semantic_2.11/jars/semantic_2.11-1.7.0.jar:${JAR_PATH}com.trueaccord.scalapb/scalapb-runtime_2.11/jars/scalapb-runtime_2.11-0.6.0-pre2.jar:${JAR_PATH}com.google.protobuf/protobuf-java/jars/protobuf-java-3.2.0.jar:${JAR_PATH}com.trueaccord.lenses/lenses_2.11/jars/lenses_2.11-0.4.10.jar:${JAR_PATH}org.scalameta/transversers_2.11/jars/transversers_2.11-1.7.0.jar:${JAR_PATH}com.github.scopt/scopt_2.11/jars/scopt_2.11-3.5.0.jar:${JAR_PATH}com.martiansoftware/nailgun-server/jars/nailgun-server-0.9.1.jar org.scalafmt.cli.Cli \
-i \
--config ${SCALAFMT_CONF} \
${FILES}
