FROM rust:latest

RUN apt update && apt install -y curl git zsh locales fonts-powerline \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && chsh -s $(which zsh)

RUN sed -i 's/ZSH_THEME=".*"/ZSH_THEME="robbyrussell"/' ~/.zshrc \
    && echo '# Rustlings alias' >> ~/.zshrc \
    && echo 'alias rl="cd /app && cargo run -- watch"' >> ~/.zshrc \
    && echo 'alias rlc="cd /app && cargo clean"' >> ~/.zshrc \
    && echo 'cd /app' >> ~/.zshrc

RUN cargo install rustlings

CMD ["zsh", "-l"]