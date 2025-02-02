# Execution times and Correctness Checks
## C Output n = {20, 26, 28}
  ![Screenshot 2025-02-02 193154](https://github.com/user-attachments/assets/435a8ea3-aada-48e1-90f8-d11810caecb5)
  ![Screenshot 2025-02-02 193315](https://github.com/user-attachments/assets/725d110d-df2d-45fd-a026-912584ede908)
  ![Screenshot 2025-02-02 194404](https://github.com/user-attachments/assets/67f90b45-4eb8-4ccc-bd64-a695b3387d66)
## x86 Output n = {20, 26, 28}
![Screenshot 2025-02-02 193201](https://github.com/user-attachments/assets/0a988411-ccc2-40c2-a670-1ce89122c130)
![Screenshot 2025-02-02 193418](https://github.com/user-attachments/assets/5fc3bac9-a109-4530-8c94-1f6e81d6d491)
![Screenshot 2025-02-02 194411](https://github.com/user-attachments/assets/d290d29e-93d2-4d8e-bdf7-cb5eb592a320)


## AVX Output n = {20, 26, 28}

## AVX2 Output n = {20, 26, 28}

![Screenshot 2025-02-02 193209](https://github.com/user-attachments/assets/b3632d02-7aa1-44de-956c-df6178915c42)
![Screenshot 2025-02-02 193407](https://github.com/user-attachments/assets/b734b8fb-97db-4c58-904f-6244af3010de)
![Screenshot 2025-02-02 194421](https://github.com/user-attachments/assets/a7e20dfd-0d03-47ef-8c96-7828b1817de5)

#Comparative Table of Execution Time

| Kernel | n = 2^20 | n = 2^26 | n = 2^28 |
|--------|:--------:|---------:|---------:|
| C      | 6.53 ms  | 367.40 ms | 1444.27 ms |
| x86    | 2.17 ms  | 122.17 ms | 523.93 ms  |
| AVX    | 0.00 ms  | 0.00 ms   | 0.00 ms    |
| AVX2   | 2.47 ms  | 138.00 ms | 564.83 ms  |

# Problems Encountered and Solutions Made
## Problem 1: Error codes in building solution in Visual Studio
The x86 Kernel was initially made in SASM and debugged thoroughly there also. At first, the results being returned were accurate and matched the solutions made in the other kernels, but when the program was migrated to the Visual Studio solution, the error message, _Access violation reading location 0xFFFFFFFFFFFFFFFF_, kept on popping up. It took two of us almost an hour to spot the bug. It turns out, we had to remove the line <br/> **mov rbp, rsp; for correct debugging** <br/>. 

## Problem 2: Bug in CKernel Testing
When the CKernel file was being created, we originally encountered a segmentation fault error when the array size was too big. It turned out that it was simple human error. The wrong parameter was being passed to malloc. The parameter being passed was the array size only without being multiplied to the size of INT32