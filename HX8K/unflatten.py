import magma as m

def UnflattenDeclaration(circuit):
    # assert?
    # add support tuples
    name = circuit.name
    args = []
    flattened = {}

    for io in circuit.IO:
        argtype = circuit.IO.__getitem__(circuit.IO, io)
        if '_' in io:
            arg = io[:io.find('_')]
            indices = list(map(int, io[io.find('_')+1:].split('_')))
            if arg not in flattened:
                flattened[arg] = [indices, argtype]
            else:
                for i in range(len(indices)):
                    if indices[i] > flattened[arg][0][i]:
                        flattened[arg][0][i] = indices[i]
        else:
            args += [io, argtype]

    for arg in flattened.keys():
        port = wrap(flattened[arg][0], flattened[arg][1])
        args += [arg, port]
        print(arg, port)

    new_circuit = m.DeclareCircuit(name, *args)
    return new_circuit

def wrap(index_list, argtype):
    if len(index_list) == 1:
        index = index_list[0] + 1
        return m.Array(index, argtype)
    else:
        index = index_list.pop(0) + 1
        return m.Array(index, wrap(index_list, argtype))


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