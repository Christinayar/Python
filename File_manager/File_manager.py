# функция для создания файла
import os
import shutil


def create_file(name, text=None):
    with open(name, 'w', encoding='utf-8') as f:
        if text:
            f.write(text)

def create_folder(name):
    try:
        os.mkdir(name)
    except FileExistsError:
        print('Такая папка уже есть')


def get_list(folders_only=False):
    result = os.listdir()
    if folders_only:
        result = [f for f in result if os.path.isdir(f)]
    print(result)


def delete_file(name):
    if os.path.isdir(name):
        os.rmdir(name)
    else:
        os.remove(name)


def copy_file(name, new_name):
    if os.path.isdir(name):
        try:
            shutil.copytree(name, new_name)
        except FileExistsError:
            print('Такая папка уже есть')
    else:
        shutil.copy(name, new_name)


if __name__ == '__main__':
    create_file('text.dat', 'some bla bla bla')
    create_folder('Consol_Manager')
    get_list()
    get_list(True)
    delete_file('Consol_Manager')
    delete_file('text.dat')
    #copy_file('Consol_Manager', 'New2')
    create_file('text.dat')
    copy_file('text.dat', 'text2.dat')