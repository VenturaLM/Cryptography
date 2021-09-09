"""
    Cipher identifier:  https://www.boxentriq.com/code-breaking/cipher-identifier
"""

import string
import math


def make_rot_n(n):
    lc = string.ascii_lowercase
    uc = string.ascii_uppercase
    trans = str.maketrans(lc + uc,
                          lc[n:] + lc[:n] + uc[n:] + uc[:n])
    return lambda s: str.translate(s, trans)


def assignment_1():
    encrypted_message = "Acakxbxakzs dkexw ewnktrzarx ewnx xewl kaxpzaksioxnwaxwntek kmuxwndko dkxewl cwixfxkxrawdoz dwxek mexnszajkwesx, eklk swixgxuxiweknxtxez txiwexnwez qkukek vwezrx ckoxnz skíxlwazbzaksw"
    forbidden_letters = ["k", "x", "z", "w"]
    for i in forbidden_letters:
        encrypted_message = encrypted_message.replace(i, "")

    return encrypted_message


def assignment_2():
    encrypted_message = "Haspadepemospotrapadoposerpeunpuinpitrépepipidopodespecupibripadorpodepamenpesapijespo,elpasipiguipienpotepaespetápemásporepalapecipeopanapidopeconpalaspemapetepimápatipocaspu"
    forbidden_letters = ["pa", "pe", "pi", "po", "pu"]
    for i in forbidden_letters:
        encrypted_message = encrypted_message.replace(i, "")

    return encrypted_message


def assignment_3():
    encrypted_message = "Oersotronshepelsatnatchosmepsllizcoapnsdloapeorrumponmeernatsoisn,apbehraosscidqhuaireirpensdsweagsufijrnarúpneqhulesddayngmnáisp,a¿dtresantartepvlecsk?"
    """
    for i in range(26):
        rot = make_rot_n(i)
        print(str(i) + " = " + rot(encrypted_message) + "\n")
    """
    message = []
    for i in range(len(encrypted_message) - 1):
        if i % 2 != 0:
            message.append(encrypted_message[i])

    solution = ""
    for i in message:
        solution += i

    return solution


def assignment_4():
    encrypted_message = "Ryaledsrtftcafthmqozxcsfgesapersedrfesdfpaaestrfaresadegyhdcokijuhstgfpeaasdfgredsaerftgezxcvbnmmasepqeqwezraaser"
    return "WORK_IN_PROGRESS"


def assignment_5():
    return


def assignment_6():
    return


def assignment_7():
    """
        Reference:  https://www.geeksforgeeks.org/implementing-atbash-cipher/
    """
    encrypted_message = "vo zngrtfl gvhgzñvngl rnxofbv gvcgl xlwrurxzwl xln zgyzhs, fnz uliñz gizwrxrlnzo wv xruiz wv hfhgrgfxrln svyivz"
    mirror_table = {'A': 'Z', 'B': 'Y', 'C': 'X', 'D': 'W', 'E': 'V',
                    'F': 'U', 'G': 'T', 'H': 'S', 'I': 'R', 'J': 'Q',
                    'K': 'P', 'L': 'O', 'M': 'Ñ', 'N': 'N', 'Ñ': 'M', 'O': 'L',
                    'P': 'K', 'Q': 'J', 'R': 'I', 'S': 'H', 'T': 'G',
                    'U': 'F', 'V': 'E', 'W': 'D', 'X': 'C', 'Y': 'B', 'Z': 'A', ',': ','}
    cipher = ""
    encrypted_message = encrypted_message.upper()
    for letter in encrypted_message:
        # checks for space
        if(letter != " "):
            # adds the corresponding letter from the lookup_table
            cipher += mirror_table[letter]
        else:
            # adds space
            cipher += " "
    return cipher.lower()


def assignment_8():
    """
        Reference:  https://www.geeksforgeeks.org/columnar-transposition-cipher/
    """
    encrypted_message = "eioaisfdscurepinatoocdrsn"
    key = "abcde"
    msg = ""

    # track key indices
    k_indx = 0

    # track msg indices
    msg_indx = 0
    msg_len = float(len(encrypted_message))
    msg_lst = list(encrypted_message)

    # calculate column of the matrix
    col = len(key)

    # calculate maximum row of the matrix
    row = int(math.ceil(msg_len / col))

    # convert key into list and sort
    # alphabetically so we can access
    # each character by its alphabetical position.
    key_lst = sorted(list(key))

    # create an empty matrix to
    # store deciphered message
    dec_cipher = []
    for _ in range(row):
        dec_cipher += [[None] * col]

    # Arrange the matrix column wise according
    # to permutation order by adding into new matrix
    for _ in range(col):
        curr_idx = key.index(key_lst[k_indx])

        for j in range(row):
            dec_cipher[j][curr_idx] = msg_lst[msg_indx]
            msg_indx += 1
        k_indx += 1

    # convert decrypted msg matrix into a string
    try:
        msg = ''.join(sum(dec_cipher, []))
    except TypeError:
        raise TypeError("This program cannot",
                        "handle repeating words.")

    null_count = msg.count('_')

    if null_count > 0:
        return msg[: -null_count]

    return msg


def assignment_9():
    """
        References:
            -Morse: https://www.boxentriq.com/code-breaking/morse-code
            -ASCII: https://www.asciitable.com/
    """
    return "MORSEYASCII"


def assignment_10():
    return


def main():
    option = int(
        input("Select hidden message [1-10]:\n> "))

    if option == 1:
        solution = assignment_1()
    elif option == 2:
        solution = assignment_2()
    elif option == 3:
        solution = assignment_3()
    elif option == 4:
        solution = assignment_4()
    elif option == 5:
        solution = assignment_5()
    elif option == 6:
        solution = assignment_6()
    elif option == 7:
        solution = assignment_7()
    elif option == 8:
        solution = assignment_8()
    elif option == 9:
        solution = assignment_9()
    elif option == 10:
        solution = assignment_10()
    else:
        print("That is not an option!\n")
        exit(1)

    if solution != None:
        print("\nMessage: " + solution + "\n")


if __name__ == "__main__":
    main()
