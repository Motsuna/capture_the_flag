from Crypto.Util.number import *
from output import pub_key,cipher


def matrix_for_clos(pub,c):
    N = len(pub)
    B = matrix(ZZ,N+1,N+1)
    B.set_block(0,0,matrix(N,1,pub))
    B.set_block(N,0,matrix(1,1,[-c]))
    B.set_block(0,1,matrix.identity(N)*2)
    B.set_block(N,1,matrix(1,N,[-1]*N))
    return B

def find_solution_vector(L):
    for row in L.rows():
        if all([(x == -1 or x == 1) for x in row[1:len(row)-1]]) and row[-1]!=0:
            return row

def convert_to_bytes(f):
    f = "".join(list(map(str,f)))
    f = f.replace("0","")
    f = f.replace("-1","0")
    f = long_to_bytes(int(f,base=2))
    return f

M = matrix_for_clos(pub_key,cipher)
L = M.LLL()
flag = find_solution_vector(L)
print(convert_to_bytes(flag))