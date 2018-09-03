#define DEBUG_TYPE "hello"
#include <llvm/Transforms/Utils/Cloning.h>
#include <llvm/Pass.h>
#include <llvm/PassManager.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/Analysis/Verifier.h>
#include <llvm/Assembly/PrintModulePass.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/InlineAsm.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/Support/FormattedStream.h>
#include <llvm/Support/MathExtras.h>
#include <map>
#include <algorithm>

using namespace llvm;


namespace {
    struct Hello : public ModulePass 
    {
        static char ID;
        Hello() : ModulePass(ID) {}
        virtual bool runOnModule(Module &M);
    };
}

char Hello::ID = 0;
static RegisterPass<Hello> X("hello", "Hello World Pass", false, false);

bool Hello::runOnModule(Module &M)
{
	// Global Variable Declarations
	GlobalVariable* gvar_int32_global_variable = new GlobalVariable(/*Module=*/M, 
	/*Type=*/IntegerType::get(M.getContext(), 32),
	/*isConstant=*/false,
	/*Linkage=*/GlobalValue::CommonLinkage,
	/*Initializer=*/0, // has initializer, specified below
	/*Name=*/"global_variable");
	gvar_int32_global_variable->setAlignment(4);
 
	// Constant Definitions
	ConstantInt* const_int32_2 = ConstantInt::get(M.getContext(), APInt(32, StringRef("0"), 10));
 
	// Global Variable Definitions
	gvar_int32_global_variable->setInitializer(const_int32_2);
	
	bool modified = false;
    //std::vector<Function *> functions;
    for(Module::iterator F = M.begin(); F != M.end(); F++) 
    {
     	if(F->getName().equals("pop_direct_branch")) continue;
		for(Function::iterator bbit = F->begin(); bbit != F->end(); bbit++)  //iterate all basic blocks of function
		{
			for(BasicBlock::iterator instit = bbit->begin(); instit != bbit->end(); instit++) //iterate all instructions of basic block 
			{
				Instruction * Inst = instit;
				if(isa<CallInst>(Inst)) 
				{
					CallInst* callInst = dyn_cast<CallInst>(Inst);
					if(callInst==NULL) continue;
			    	//errs() << * callInst << "\n";
					Function *callee = callInst->getCalledFunction();
					StringRef s = callee->getName();
					//errs() << *callee << "\n";
					if(s.startswith("p")&&!s.equals("pop_direct_branch"))
					{
				  		ValueToValueMapTy map;     //should be empty?
				  		if(callee->isDeclaration()) continue;
				  		Function *clone_function = CloneFunction(callee,map,false,NULL);
				  		if(clone_function == NULL) continue;
				 		// errs() << *clone_function << "\n";
				  		callee->getParent()->getFunctionList().push_back(clone_function);
				  		clone_function->setLinkage(GlobalValue::InternalLinkage);   ///////doubbbbbbttttttttttttttt
				  		callInst->setCalledFunction(clone_function);
				  
				  		if (callee->getReturnType()->isVoidTy()==0)  //int type
						{
							int flag = 0;
							for(Function::iterator bbit1 = clone_function->begin(); bbit1 != clone_function->end(); bbit1++)
				  			{
								for(BasicBlock::iterator inst1 =bbit1->begin(); inst1 != bbit1->end(); inst1++)
								{
									CallInst* callInst1 = dyn_cast<CallInst>(inst1);
									if(callInst1==NULL) continue;
									if(callInst1->getCalledFunction()->getName().equals("pop_direct_branch"))
									{
										flag = 1;
										break;
									}
								 }
								 if(flag==1) break;
							}

							if(flag==1) continue;

				  			for(Function::iterator bbit1 = clone_function->begin(); bbit1 != clone_function->end(); bbit1++)
				  			{
								for(BasicBlock::iterator inst1 =bbit1->begin(); inst1 != bbit1->end(); inst1++)
								{
									Instruction * Inst1 = inst1;
									ReturnInst* returninst = dyn_cast<ReturnInst>(Inst1); 
									if(returninst==NULL) continue;
									Value* returnvalue = returninst->getReturnValue();
									if(returnvalue==NULL) continue;
									//errs() << * returnvalue  << "\n";
									StoreInst *store_inst = new StoreInst(returnvalue,gvar_int32_global_variable, false,returninst);
									store_inst->setAlignment(4);
									//Function* function_pop_direct_branch = callee->getParent()->getFunction("pop_direct_branch");
									Function* function_pop_direct_branch = M.getFunction("pop_direct_branch");
					    			//errs() << *store_inst << "\n";
									CallInst* call_1 = CallInst::Create(function_pop_direct_branch, "", returninst);
									//errs() << * call_1 << "\n";
								}
				  			}
				  			//errs() << *clone_function << "\n";
							Instruction *tempInst = ++instit;
							Instruction *tempInst2 = ++instit;
							instit--;
							instit--; 
							Instruction *tempinst = dyn_cast<Instruction>(tempInst);
							Value *left_side = tempinst->getOperand(1); //get LHS varible
							
							LoadInst *loadinst = new LoadInst(gvar_int32_global_variable, "", tempInst2);  //insert before the next instruction of callinst
							loadinst->setAlignment(4);
							//errs() << *loadinst << "\n";
							
							//Instruction *tempinst = dyn_cast<Instruction>(callInst);
							//tempinst->eraseFromParent();
							StoreInst* store_inst1 = new StoreInst(loadinst,left_side, false, tempInst2);
							store_inst1->setAlignment(4);
							
							modified = true;
						}

						else
						{
							int flag = 0;
							for(Function::iterator bbit1 = clone_function->begin(); bbit1 != clone_function->end(); bbit1++)
				  			{
								for(BasicBlock::iterator inst1 =bbit1->begin(); inst1 != bbit1->end(); inst1++)
								{
									CallInst* callInst1 = dyn_cast<CallInst>(inst1);
									if(callInst1==NULL) continue;
									if(callInst1->getCalledFunction()->getName().equals("pop_direct_branch"))
									{
										flag = 1;
										break;
									}
								 }
								 if(flag==1) break;
							}

							if(flag==1) continue;

				  			for(Function::iterator bbit1 = clone_function->begin(); bbit1 != clone_function->end(); bbit1++)
				  			{
								for(BasicBlock::iterator inst1 =bbit1->begin(); inst1 != bbit1->end(); inst1++)
								{
									Instruction * Inst1 = inst1;
									ReturnInst* returninst = dyn_cast<ReturnInst>(Inst1); 
									if(returninst==NULL) continue;
									Function* function_pop_direct_branch = M.getFunction("pop_direct_branch");
					    			//errs() << *store_inst << "\n";
									CallInst* call_1 = CallInst::Create(function_pop_direct_branch, "", returninst);
									//errs() << * call_1 << "\n";
								}
				  			}
				  			modified = true;
						}
						//errs() << *clone_function << "\n";
					}
				}
			}	
		}
    }
    return modified;
} 