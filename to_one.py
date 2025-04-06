from pathlib import Path

name = "fil.md"

def process_directory(directory):
    files = {}  # Словарь для хранения результатов

    for item in directory.iterdir():
        if item.name.startswith('.'):  # Игнорируем скрытые файлы и папки
            continue

        if item.is_file():  # Если это файл
            try:
                with open(item, "r") as file:
                    content = file.read()
                files[str(item)] = content
            except Exception as e:
                print(f"Ошибка при чтении файла {item}: {e}")

        elif item.is_dir():  # Если это директория
            print(f"Обрабатывается директория: {item}")
            # Рекурсивно обрабатываем поддиректорию
            files.update(process_directory(item))

    return files

def fil(root_dir):
    root_path = Path(root_dir)

    if not root_path.exists():
        print(f"Директория {root_dir} не существует.")
        return {}

    return process_directory(root_path)

if __name__ == "__main__":
    root_dir = "."
    files = fil(root_dir)
    
    # Открываем файл fil.md ОДИН РАЗ для записи всего содержимого
    with open(name, "w") as fi:
        for file_path, content in files.items():
            fi.write(f"{file_path}:\n```{file_path.split('.')[-1]}\n{content}```\n")
