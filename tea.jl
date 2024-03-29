function encrypt(v::Vector{UInt32}, k::Vector{UInt32})
    v0::UInt32 = v[1]
    v1::UInt32 = v[2]
    sum::UInt32 = 0
    delta::UInt32 = 0x9E3779B9
    
    k0::UInt32 = k[1]
    k1::UInt32 = k[2]
    k2::UInt32 = k[3]
    k3::UInt32 = k[4]
    for i = 1:32
        sum += delta
        v0 += ((v1<<4) + k0) ⊻ (v1 + sum) ⊻ ((v1>>5) + k1)
        v1 += ((v0<<4) + k2) ⊻ (v0 + sum) ⊻ ((v0>>5) + k3)
    end
    v[1]=v0
    v[2]=v1
end

function encrypt_block(data::Vector{UInt32}, key::Vector{UInt32})
    blocks::UInt32 = 0
    #i::UInt32 =0
    len::UInt32 = length(data)

    #data32::UInt32 = data
    
    blocks = trunc(((len) + 7) / 8) + 1
    data[blocks] = len;
    len = blocks * 8

    for i = 1:blocks
        encrypt(data[i*2], key)
    end

end

v::Vector{UInt32} = UInt32[1,2]
k::Vector{UInt32} = UInt32[1,2,3,4]

encrypt_block(v, k)

print(v)