function x = emailFeatures(word_indices)
%EMAILFEATURES takes in a word_indices vector and produces a feature vector
%from the word indices
%   x = EMAILFEATURES(word_indices) takes in a word_indices vector and 
%   produces a feature vector from the word indices. 

% Total number of words in the dictionary
n = 1899;

% You need to return the following variables correctly.
x = zeros(n, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return a feature vector for the
%               given email (word_indices). To help make it easier to 
%               process the emails, we have have already pre-processed each
%               email and converted each word in the email into an index in
%               a fixed dictionary (of 1899 words). The variable
%               word_indices contains the list of indices of the words
%               which occur in one email.
% 
%               Concretely, if an email has the text:
%
%                  The quick brown fox jumped over the lazy dog.
%
%               Then, the word_indices vector for this text might look 
%               like:
%               
%                   60  100   33   44   10     53  60  58   5
%
%               where, we have mapped each word onto a number, for example:
%
%                   the   -- 60
%                   quick -- 100
%                   ...
%
%              (note: the above numbers are just an example and are not the
%               actual mappings).
%
%              Your task is take one such word_indices vector and construct
%              a binary feature vector that indicates whether a particular
%              word occurs in the email. That is, x(i) = 1 when word i
%              is present in the email. Concretely, if the word 'the' (say,
%              index 60) appears in the email, then x(60) = 1. The feature
%              vector should look like:
%
%              x = [ 0 0 0 0 1 0 0 0 ... 0 0 0 0 1 ... 0 0 0 1 0 ..];
%
%
%keyboard;
% By right getVocabList should have a try catch block
vocabList = getVocabList();
words_len = length(word_indices);

% This could be rather wasteful, but it works and I've kept it here for knowledge
for word_index = 1:words_len
    try
        if ( vocabList{word_indices(word_index)} )
            x(word_indices(word_index)) = 1;
%            x(word_index) = 1;
        else
            x(word_indices(word_index)) = 0;
%            x(word_index) = 0;
        endif
    catch
%        x(word_index) = 0;	% A false value is provided
            x(word_indices(word_index)) = 0;
    end
end

% ======================================================================
% -----------------------------------------------------------------------
% alternative 1
% -----------------------------------------------------------------------
% x(word_indices) = 1;
% -----------------------------------------------------------------------
% ======================================================================
% -----------------------------------------------------------------------
% alternative 2
% -----------------------------------------------------------------------
% for i = word_indices
% x(i) = 1;
% end
% -----------------------------------------------------------------------
% unique(word_indices); % also useful as word_indices has duplicate numbers in its vector


% =========================================================================
    

end
