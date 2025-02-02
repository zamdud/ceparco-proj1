# Execution times and Correctness Checks
Note: Vector X was initialized with values from 1 to 2^n. 
## C Output n = {20, 26, 28}
![474883264_1177837143759602_8065474038885258091_n](https://github.com/user-attachments/assets/fa479166-6c17-4f69-bd7d-6a8610093771)
![474743415_626681566520551_2716139167279742164_n](https://github.com/user-attachments/assets/1b535ac5-637b-48ab-ac45-92b1b188c14a)
![475117369_1951113718709769_6691974893103664675_n](https://github.com/user-attachments/assets/e1d269ab-fff5-4121-a517-5ae2eae3843d)
## x86 Output n = {20, 26, 28}
![474665894_1002912875018444_8939886419673477800_n](https://github.com/user-attachments/assets/a484c463-5a70-48d0-9d38-0ebc76757421)
![475331159_955771702854468_3198469754645509574_n](https://github.com/user-attachments/assets/6089be25-1ab5-4684-8c0a-bee58a796d06)
![472792845_600168062716846_3154765735949087294_n](https://github.com/user-attachments/assets/02d2c069-8072-442b-a68c-abef09883c7d)

## AVX Output n = {20, 26, 28}
![475515754_1340525140294520_1882704131239343654_n](https://github.com/user-attachments/assets/2fb8ddde-7017-4745-9377-5b5e82053512)
![475730209_1535973197095897_2370950548286449121_n](https://github.com/user-attachments/assets/da9d56a7-0c6c-4d44-a854-ef2e1a9551f1)
![475293737_596015853298077_5085979813935149831_n](https://github.com/user-attachments/assets/fc3de216-b7e7-4b75-b9c3-c81bea713b53)
## AVX2 Output n = {20, 26, 28}
![473831703_1189643536218268_4677421568501082143_n](https://github.com/user-attachments/assets/9eb42a2e-0b98-407b-815f-5bfed013bc68)
![473713117_1807243583385295_8452738119454171780_n](https://github.com/user-attachments/assets/ac1d6c8b-bc21-4405-8f2f-c7f6f2d4fda9)
![474883264_1658615388065836_3786751118692535465_n](https://github.com/user-attachments/assets/a67c4b55-b0c2-44d6-a702-2668e612fe72)


#Comparative Table of Execution Time

| Kernel | n = 2^20 | n = 2^26 | n = 2^28 |
|--------|:--------:|---------:|---------:|
| C      | 31.14 ms  | 178.00 ms | 1525.38 ms |
| x86    | 1.04 ms  | 64.58 ms | 667.4 ms  |
| AVX    | 2.12 ms  | 79.28 ms   |403.12 ms    |
| AVX2   | 1.70 ms  | 57.18 ms | 317.46 ms  |

### Analysis
The C kernel performed the slowest out of the four kernels tested given that the translation from C to machine-level code may not be as optimized as directly writing assembly code. However, when it came to sequential vs parallel computing in x86 assembly, the latter can be deemed more efficient, especially when handling exponentially more data. However, when data is relatively small (n=2^20; n=2^26), there is not much of a significant difference between the x86 kernel and the AVX and AVX2 kernels. This could be because the more extensive setup for the SIMD operations and registers and relative reduction in the amount of loops executed can't make up for the simplicity and direct approach of sequential computing in x86. But to repeat, the benefits of making use of SIMD instructions truly manifest when handling a lot more data exponentially. This is seen in the performance of the AVX and AVX2 kernels when n = 2^28 as they were respectively 73.57% and 79.19% faster than the C kernel. 

# Problems Encountered and Solutions Made
## Problem 1: Error codes in building solution in Visual Studio
The x86 Kernel was initially made in SASM and debugged thoroughly there also. At first, the results being returned were accurate and matched the solutions made in the other kernels, but when the program was migrated to the Visual Studio solution, the error message, _Access violation reading location 0xFFFFFFFFFFFFFFFF_, kept on popping up. It took two of us almost an hour to spot the bug. It turns out, we had to remove the line <br/> **mov rbp, rsp; for correct debugging** <br/>. 

## Problem 2: Bug in CKernel Testing
When the CKernel file was being created, we originally encountered a segmentation fault error when the array size was too big. It turned out that it was simple human error. The wrong parameter was being passed to malloc. The parameter being passed was the array size only without being multiplied to the size of INT32
