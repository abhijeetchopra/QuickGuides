# QuickGuide | Java

Requirements:

```bash
# install JDK
brew install openjdk
brew install corretto

# install jenv - tool to manage java versions
brew install jenv

# verify jenv
jenv doctor

# enable jenv plugins
jenv enable-plugin export
jenv enable-plugin maven

# find jdk root paths
/usr/libexec/java_home -V

# add jdk to jenv to manage
jenv add <jdk_path>

# list java versions available via jenv
jenv versions

# system-wide java version
jenv global <version>

# project-wide java version
jenv local <version>

# shell instance java version
jenv shell <version>

# check current java version
java -version
```
