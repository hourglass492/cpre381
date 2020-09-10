
def toHexAndExtend(decimalNum, numOfByts):
    decimalNum = (16 ** (numOfByts)) + decimalNum

    return hex(decimalNum)[3:]

def toBinaryAndExtend(decimalNum, numOfBits):
    decimalNum = (2 ** (numOfBits)) + decimalNum
    temp = bin(decimalNum)
    temp = bin(decimalNum)[3:]
    return bin(decimalNum)[3:]


def parseRW(location):
    array = []
    array.append(location[:location.index("(")].strip("()"))
    array.append(location[location.index("("):].strip("()"))
    return array

def add(destination, reg1, reg2):
    control = 0
    print("--addi, " + str(destination) + ", "  + str(reg1) + ", " + str(reg2))
    print("-- add " + str(reg1) + " and " + str(reg2) +  " and store in " + str(destination), end="\n\n")
    destination = int(destination.replace("$", ""))
    reg1 = int(reg1.replace("$", ""))
    reg2 = int(reg2.replace("$", ""))

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")
    print("\t\t rt_s <= \"" + toBinaryAndExtend(reg2, 5) + "\";")

def addi(destination, reg1, immedate):
    control = 1
    print("--addi, " + str(destination) + ", " + str(destination) + ", " + str(reg1) + ", " + str(immedate))
    print("-- add " + str(immedate) + " to register " + str(reg1) + " and store in " + str(destination) ,end="\n\n")
    destination = int(destination.replace("$", ""))
    reg1 = int(reg1.replace("$", ""))
    immedate = int(immedate)

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")
    print("\t\t imm <= X\"" + toHexAndExtend(immedate, 4) + "\";")
    print("\t\t rd_s <= \"" + toBinaryAndExtend(destination, 5) + "\";")


def sub(destination, reg1, reg2):
    control = 2
    print("--sub, " + str(destination) + ", " + str(reg1) + ", " + str(reg2))
    print("-- sub " + str(reg1) + " from " + str(reg2) + " and store in " + str(destination), end="\n\n")
    destination = int(destination.replace("$", ""))
    reg1 = int(reg1.replace("$", ""))
    reg2 = int(reg1.replace("$", ""))

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")
    print("\t\t rt_s <= \"" + toBinaryAndExtend(reg2, 5) + "\";")

def subi(destination, reg1, immedate):
    control = 3
    print("--subi, " + str(destination) + ", " + str(destination) + ", " + str(reg1) + ", " + str(immedate))
    print("-- sub " + str(immedate) + " from register " + str(reg1) + " and store in " + str(destination) ,end="\n\n")
    destination = int(destination.replace("$", ""))
    reg1 = int(reg1.replace("$", ""))
    immedate = int(immedate)

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")
    print("\t\t imm <= X\"" + toHexAndExtend(immedate, 4) + "\";")
    print("\t\t rd_s <= \"" + toBinaryAndExtend(destination, 5) + "\";")


def sw(regToStore, reg1, immedate):
    control = 5

    print("--sw, " + str(regToStore) + ",\t" + str(immedate) + "(" + str(reg1) + ")")
    print("-- store " + str(regToStore) + " at memory location " + str(reg1) + " plus " + str(immedate), end="\n\n")
    regToStore = int(regToStore.replace("$", "0x"),16)
    reg1 = int(reg1.replace("$", ""))
    immedate = int(immedate)

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")

    # The register we are storing
    print("\t\t rt_s <= \"" + toBinaryAndExtend(regToStore, 5) + "\";")

    # the register we get the location from
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")

    # the immideate offset
    print("\t\t imm <= X\"" + toHexAndExtend(immedate, 4) + "\";")


def lw(loadReg, reg1, immedate):
    control = 7

    print("--lw, " + str(loadReg) + ",\t" + str(immedate) + "(" + str(reg1) + ")")
    print("-- load " + str(immedate) + " plus " + str(reg1) + " from memory into " + str(loadReg), end="\n\n")
    loadReg = int(loadReg.replace("$", "0x"),16)
    reg1 = int(reg1.replace("$", ""))
    immedate = int(immedate)

    print("\t\tctl <= \"" + toBinaryAndExtend(control, controlSize) + "\";")

    # The register we are storing
    print("\t\t rt_d <= \"" + toBinaryAndExtend(loadReg, 5) + "\";")

    # the register we get the location from
    print("\t\t rs_s <= \"" + toBinaryAndExtend(reg1, 5) + "\";")

    # the immideate offset
    print("\t\t imm <= X\"" + toHexAndExtend(immedate, 4) + "\";")









file = open("./program", "r")
controlSize = 3



for line in file:
    line = line.replace("," ,"")
    line = line.split()
    i = 0
    while i < len(line):
        if line[i] == "add":
            add(line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif line[i] == "addi":
            addi(line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif line[i] == "sub":
            sub(line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif line[i] == "subi":
            subi(line[ i +1], line[ i +2], line[ i +3])
            i += 4
        elif line[i] == "sw":
            sw(line[ i +1],  parseRW(line[ i +2])[1], parseRW(line[ i +2])[0])
            i += 3
        elif line[i] == "lw":
            lw(line[ i +1], parseRW(line[ i +2])[1], parseRW(line[ i +2])[0])
            i += 3
        else:
            print("Could not parse " + line[i] + " found at " + str(i))
            i += 1
        print("wait for gCLK_HPER;\n\n")
