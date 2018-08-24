import magma as m

#
# Wrap a circuit declaration with a new interface
# - unflattens all array arguments back into array structure
#
def WrapDeclaration(decl):
    # assert?
    # add support tuples
    name = decl.name+'Wrapped'
    args = []
    wrapped = {}

    # find all array index arguments (i.e. I0_1_0)
    for io in decl.IO:
        argtype = decl.IO.__getitem__(decl.IO, io)
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
        print(arg, port)

    # wire original circuit to wrapped version
    circuit = decl()
    new_circuit = m.DefineCircuit(name, *args)
    for io in circuit.IO:
        argtype = decl.IO.__getitem__(decl.IO, io)
        if '_' in io:
            arg = io[:io.find('_')]
            indices = list(map(int, io[io.find('_')+1:].split('_')))
            m.wire(getattr(circuit, io), nest(getattr(new_circuit, arg), indices))
        else:
            m.wire(getattr(circuit, io), getattr(new_circuit, io))
    m.EndDefine()
    return new_circuit

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

# cur_arg = ''
#     for io in circuit.IO:
#         if '_' in io:
#             next_arg = io[:io.find('_')]
#             indices = list(map(int, io[io.find('_')+1:].split('_')))
#             if cur_arg == '':
#                 cur_arg = next_arg
#             if next_arg != cur_arg:
#                 port = wrap(indices, circuit.IO.__getitem__(circuit.IO, io))
#                 args += [cur_arg, port]
#                 print(cur_arg, port)
#                 cur_arg = next_arg