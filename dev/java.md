


# Env

```bash

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk/"


```

# Eclipse 

```bash

# eclipse.ini

-vm
/usr/lib/jvm/java-17-openjdk/bin/java

```

# Gradle

```bash

export PATH=$PATH:/optd/opt/gradle-8.3/bin/

gradle tasks        #列出所有任务

gradle [taskName]   #执行任务

```


# 编译单个文件

```bash

javac -classpath .;C:\path\lib1.jar;C:\path\lib1.jar -d . C:\path\file.java

```