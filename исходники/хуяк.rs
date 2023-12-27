use std::fs;
use std::env;
use std::io;
use std::process::ExitCode;
use std::path::Path;

#[path="./диагностика.rs"]
#[macro_use]
mod диагностика;
#[path="./лексика.rs"]
mod лексика;
#[path="./синтаксис.rs"]
mod синтаксис;
#[path="./пп.rs"]
mod пп;
#[path="./эльф.rs"]
mod эльф;

use лексика::Лексер;
use синтаксис::Модуль;
use пп::Программа;

type Результат<Тэ> = Result<Тэ, ()>;

fn главная() -> Результат<()> {
    let mut аргы = env::args();
    let программа = аргы.next().expect("программа");

    let пример = || {
        eprintln!("Пример: {программа} [опции] <файл.хуя>");
        eprintln!("Опции:");
        eprintln!("    -интер    Интерпретировать программу вместо её компиляции");
    };

    let mut путь_к_файлу = None;
    let mut интер = false;

    loop {
        match аргы.next() {
            Some(арг) => match арг.as_str() {
                "-интер" => интер = true,
                _ => {
                    if путь_к_файлу.is_some() {
                        пример();
                        eprintln!("ОШИБКА: компиляции нескольких файлов не поддерживается на данный момент.");
                        return Err(());
                    } else {
                        путь_к_файлу = Some(арг);
                    }
                }
            }
            None => break,
        }
    }

    let путь_к_файлу = if let Some(путь_к_файлу) = путь_к_файлу {
        путь_к_файлу
    } else {
        пример();
        eprintln!("ОШИБКА: требуется файл с программой");
        return Err(());
    };

    let содержание: Vec<char> = match fs::read_to_string(&путь_к_файлу) {
        Ok(содержание) => содержание.chars().collect(),
        Err(ошибка) => {
            match ошибка.kind() {
                io::ErrorKind::NotFound => eprintln!("ОШИБКА: файл «{путь_к_файлу}» не найден"),
                // СДЕЛАТЬ: локализировать те ошибки, которые возможно.
                _ => eprintln!("ОШИБКА: не получилось прочитать файл «{путь_к_файлу}»: {ошибка}"),
            }
            return Err(());
        }
    };
    let mut лекс = Лексер::новый(&путь_к_файлу, &содержание);
    let модуль = Модуль::разобрать(&mut лекс)?;
    let mut программа = Программа::default();
    программа.скомпилировать_модуль(модуль)?;
    if интер {
        программа.интерпретировать("главная")
    } else {
        эльф::сгенерировать(&Path::new(&путь_к_файлу).with_extension(""), &программа)
    }
}

fn main() -> ExitCode {
    match главная() {
        Ok(()) => ExitCode::SUCCESS,
        Err(()) => ExitCode::FAILURE,
    }
}
