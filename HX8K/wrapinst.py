import magma as m

#
# Wrap a circuit declaration with a new interface
# - unflattens all array arguments back into array structure
#


def WrapInst(inst):
    # assert?
    # add support tuples
    name = inst.name+'Wrapped'
    args = []
    wrapped = {}

    # find all array index arguments (i.e. I0_1_0)
    for io in inst.IO:
        argtype = inst.IO.__getitem__(inst.IO, io)
        if '_' in io:
            arg = io[:io.find('_')]
            indices = list(map(int, io[io.find('_')+1:].split('_')))
            if arg not in wrapped:
                wrapped[arg] = [indices, argtype]
            else:
                for i in range(len(indices)):
                    if indices[i] > wrapped[arg][0][i]:
                        wrapped[arg][0][i] = indices[i]
        else:
            args += [io, argtype]

    # add them back as complete arrays
    for arg in wrapped.keys():
        port = wrap(wrapped[arg][0], wrapped[arg][1])
        args += [arg, port]

    new_circuit = {}
    for i in range(0, len(args), 2):
        new_circuit[args[i]] = m.Flip(args[i + 1])()

    # wire original circuit to wrapped version
    for io in inst.IO:
        argtype = inst.IO.__getitem__(inst.IO, io)
        if '_' in io:
            arg = io[:io.find('_')]
            indices = list(map(int, io[io.find('_')+1:].split('_')))
            m.wire(getattr(inst, io), nest(new_circuit[arg], indices))
        else:
            m.wire(getattr(inst, io), new_circuit[io])
    IO = []
    for key, value in new_circuit.items():
        IO.extend([key, value])
    return m.AnonymousCircuit(*IO)


def wrap(index_list, argtype):
    if len(index_list) == 1:
        index = index_list[0] + 1
        return m.Array(index, argtype)
    else:
        index = index_list.pop(0) + 1
        return m.Array(index, wrap(index_list, argtype))


def nest(array, index_list):
    if len(index_list) == 1:
        index = index_list[0]
        return array[index]
    else:
        index = index_list.pop(0)
        return nest(array[index], index_list)
