#pragma OPENCL EXTENSION cl_khr_fp64 : enable

kernel void iterate(global double* input, global double* inputZ0, global ushort* output)
{
    size_t i = get_global_id(0);
    
    double a = input[i * 2];
    double b = input[i * 2 + 1];
    
    double a0 = inputZ0[i * 2];
    double b0 = inputZ0[i * 2 + 1];
    
    double newA, newB;
    
    // distance from zero
    double inner = a * a + b * b;
    float dist = sqrt((float)inner);
    
    float exp = 2.83;
    float scaled = pow(dist, exp);
    output[i] = 1-(ushort)scaled;
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