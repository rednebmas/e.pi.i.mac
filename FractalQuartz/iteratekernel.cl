#pragma OPENCL EXTENSION cl_khr_fp64 : enable

kernel void iterate(global double* input, global double* inputZ0, global ushort* output)
{
    size_t i = get_global_id(0);
    
    double a = input[i * 2];
    double b = input[i * 2 + 1];
    
    double a0 = input[i * 2];
    double b0 = input[i * 2 + 1];
    
    double newA, newB;
    
    // distance from zero
    double inner = a * a + b * b;
    float dist = sqrt((float)inner);
    
    float exp = 2.83;
    float scaled = pow(dist, exp);
    ushort au = (ushort)a;
    output[i] = (ushort)(((float)(i % 1600) / 1600) * 255);
    return;
    
    
    if (a < -20.0)
    {
        output[i] = 100;
        return;
    }
    
    for (int k = 0; k < 254; k++)
    {
        if (a > 2 || b > 2)
            break;
        
        newA = (a * a)
        - (b * b)
        + a0;
        newB = 2 * b * a
        + b0;
        
        a = newA;
        b = newB;
        output[i] += 1;
    }
}