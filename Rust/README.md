# QuickGuide | Rust

[Rust](https://rust-lang.org/learn) is installed and managed by the [rustup](https://rust-lang.github.io/rustup/) tool


## Install

- <https://www.rust-lang.org/tools/install>

## Commands

```bash
which rustup

rustup show

rustup update

rustc --version
```

## Hello world

### Code

```bash
fn main() {
    println!("Hello World!");
}
```

Save above code in file named `hello.rs`

### Compile

```bash
$ rustc hello.rs
```

### Execute

```bash
$ ./hello
Hello World!
```

## References

- <https://rust-lang.org>
- <https://www.rust-lang.org/learn>
- <https://rust-lang.github.io/rustup>